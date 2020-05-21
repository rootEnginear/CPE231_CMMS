const router = require("express").Router();
const { sql } = require("../database");

router.get("/", async (req, res) => {
  try {
    const result = await sql`SELECT emp_id, emp_firstname, emp_lastname FROM employees WHERE emp_department = 1`;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

module.exports = router;
