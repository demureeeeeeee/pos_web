require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { migrate } = require('./db-pg');


const app = express();
app.use(cors());
app.use(express.json());


(async ()=>{
await migrate();
// mount routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/products', require('./routes/products'));
app.use('/api/sales', require('./routes/sales'));
app.use('/api/customers', require('./routes/customers'));
app.use('/api/promotions', require('./routes/promotions'));


const PORT = process.env.PORT || 4000;
app.listen(PORT, ()=> console.log('Server running on', PORT));
})();
