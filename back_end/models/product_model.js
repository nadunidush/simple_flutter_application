const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    id:Number,
    title:String,
    price:Number,
    description: String,
    image: String,
    screen: String,
    processor: String,
    camera: String,
    battery: String,
    quantity: Number,
});

module.exports = mongoose.model("Product",productSchema);