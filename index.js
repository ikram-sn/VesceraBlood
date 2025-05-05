const express = require("express");
const cors = require("cors");
const connections = require("./DB.js");
const app = express();
const port = 4000;
app.use(cors());
app.use(express.json());
app.get(connections);
app.use(express.static('public'));


app.post('/register', (req, res) => {
    const { username, phone, email, password, blood_type, donation_type, district, commune } = req.body;
  
    // التحقق من كل الحقول
    if (!username || !phone || !email || !password || !blood_type || !donation_type || !district || !commune) {
      return res.status(400).json({ error: 'جميع الحقول مطلوبة' });
    }
  
    // إدراج المتبرع في قاعدة البيانات
    const query = `
      INSERT INTO donors (username, phone, email, password, blood_type, donation_type, district, commune)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;
    connections.query(
      query,
      [username, phone, email, password, blood_type, donation_type, district, commune],
      (err, results) => {
        if (err) {
          console.error('Error inserting donor:', err);
          if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: 'الإيميل مستخدم من قبل' });
          }
          return res.status(500).json({ error: 'خطأ في قاعدة البيانات' });
        }
  
        // زيادة units_added بناءً على blood_type
        const updateQuery = `
          UPDATE blood_inventory
          SET units_added = units_added + 1
          WHERE blood_type = ?
        `;
        connections.query(updateQuery, [blood_type], (updateErr) => {
          if (updateErr) {
            console.error('Error updating inventory:', updateErr);
            return res.status(500).json({ error: 'خطأ في تحديث المخزون' });
          }
          res.status(201).json({ message: 'تم تسجيل المتبرع', donor_id: results.insertId });
        });
      }
    );
  });
  // تسجيل الدخول
app.post('/login', (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: 'الإيميل وكلمة السر مطلوبين' });
  }
  connections.query(
    'SELECT donor_id, username FROM donors WHERE email = ? AND password = ?',
    [email, password],
    (err, results) => {
      if (err || results.length === 0) {
        return res.status(401).json({ error: '  بيانات غير صحيحة'   });
      }
      res.json({ message: 'تسجيل دخول ناجح', donor_id: results[0].donor_id, username: results[0].username });
    }
  );
});
////
app.get('/donors', (req, res) => {
  const query = `
    SELECT donor_id, username, phone, email, blood_type, donation_type, district, commune, created_at
    FROM donors
  `;
  connections.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching donors:', err);
      return res.status(500).json({ error: 'خطأ في جلب المتبرعين' });
    }
    res.status(200).json(results);
  });
});
/////
  // جلب المخزون
app.get('/blood-inventory', (req, res) => {
    const query = `
      SELECT blood_type, units_added, units_used, (units_added - units_used) AS units_available
      FROM blood_inventory
    `;
    connections.query(query, (err, results) => {
      if (err) {
        console.error('Error fetching inventory:', err);
        return res.status(500).json({ error: 'خطأ في قاعدة البيانات' });
      }
      res.status(200).json(results);
    });
  });

app.listen(port, () => {
  console.log("server run onport", port);
});
