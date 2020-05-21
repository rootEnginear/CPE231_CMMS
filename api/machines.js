const router = require("express").Router();
const { sql } = require("../database");

router.get("/:id/parts", async (req, res) => {
  if (isNaN(+req.params.id)) return 400;
  try {
    const result = await sql`
      SELECT mp.part_id, p.part_name, pc.pcat_name, p.part_quantity
        FROM machine_parts mp
        JOIN parts p ON mp.part_id = p.part_id
        JOIN part_categories pc ON p.part_category = pc.pcat_id
        WHERE mp.mac_id = ${req.params.id}
    `;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

module.exports = router;
