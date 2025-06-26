const express = require('express');
const router = express.Router();
const CartItem = require('../models/cart_items_model');

//Add to the cart the product
router.post('/cart', async (req, res) => {
  try {
    const { productId, name, price, quantity } = req.body;
    const item = new CartItem({ productId, name, price, quantity });
    await item.save();
    res.status(201).json({ message: 'Item added to cart', item });
  } catch (err) {
    res.status(500).json({ error: 'Failed to add to cart' });
  }
});

//get the product from mongodb
router.get('/cart', async (req, res) => {
  const items = await CartItem.find();
  res.json(items);
});

// Update quantity
router.put('/cart/:id', async (req, res) => {
  await CartItem.findByIdAndUpdate(req.params.id, { quantity: req.body.quantity });
  res.json({ message: 'Quantity updated' });
});

// Delete product
router.delete('/cart/:id', async (req, res) => {
  await CartItem.findByIdAndDelete(req.params.id);
  res.json({ message: 'Item removed' });
});

module.exports = router;
