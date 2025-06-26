const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const connectDb = require('./config/mongodb_config');
const userRoutes = require('./routes/user_route');
const productRoute = require('./routes/product_route');
const cartRoute = require('./routes/cart_route');
require('dotenv').config();
const PORT = process.env.PORT || 8000;

const app = express();
connectDb();

app.use(cors());
app.use(bodyParser.json());
app.use('/users', userRoutes);
app.use('/', productRoute);
app.use('/', cartRoute);


app.listen(PORT, () => console.log(`Server running on port ${PORT}`));