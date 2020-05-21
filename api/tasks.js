const router = require("express").Router();
const { sql } = require("../database");

router.get("/", async (req, res) => {
  try {
    const result = await sql`
      SELECT t.task_id, emp_id_reporter, emp_id, emp_firstname, emp_lastname, tstat_datetime, tstype_name, task_finished
        FROM tasks t
        JOIN employees e ON t.emp_id_reporter = e.emp_id
        JOIN (
          SELECT * FROM task_status WHERE tstat_id IN (
            SELECT MAX(tstat_id) AS tstat_id FROM task_status GROUP BY task_id
            )
          ) ts ON t.task_id = ts.task_id
        JOIN task_status_type tst ON ts.tstype_id = tst.tstype_id
        ORDER BY t.task_id;
      `;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/by_monthes", async (req, res) => {
  try {
    const result = await sql`SELECT ts.task_id, ts.tstat_datetime, t.task_finished FROM task_status ts JOIN tasks t ON t.task_id = ts.task_id WHERE tstype_id = 1`;
    // change `task_finished` to boolean and extract month from `tstat_datetime`
    const result_transformed = result.map((r) => ({
      ...r,
      task_finished: !!r.task_finished,
      month: new Date(r.tstat_datetime).getMonth(),
    }));
    // separate data by month
    const result_by_month = result_transformed.reduce(
      (all, current) => {
        all[current.month].push(current);
        return all;
      },
      Array(12)
        .fill(0)
        .map((e) => [])
    );
    res.json(result_by_month);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/available_status", async (req, res) => {
  try {
    const result = await sql`SELECT * FROM task_status_type`;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/:id", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  try {
    const result = await sql`
      SELECT t.task_id, t.emp_id_reporter, t.task_finished, e.emp_firstname, e.emp_lastname, t.mac_id, m.mac_name, t.task_details, MIN(ts.tstat_datetime) AS tstat_datetime_min
        FROM task_status ts
        JOIN tasks t ON ts.task_id = t.task_id
        JOIN employees e ON t.emp_id_reporter = e.emp_id
        JOIN machines m ON t.mac_id = m.mac_id
        WHERE ts.task_id = ${req.params.id};
    `;
    res.json(result[0]);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.post("/:id", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  if (
    !(
      req.body.task_status.tstat_datetime &&
      req.body.task_status.tstype_id &&
      req.body.task_status_mechanics.length
    )
  )
    return res.sendStatus(400);
  const query_status = await sql`
    INSERT INTO task_status VALUES(NULL,${req.params.id},${req.body.task_status.tstat_datetime},${req.body.task_status.tstat_details},${req.body.task_status.tstype_id});
  `;
  const added_id = query_status.insertId;
  for (mechanic of req.body.task_status_mechanics)
    await sql`INSERT INTO task_status_mechanics VALUES(${added_id},${mechanic})`;
  for (part of req.body.task_status_part)
    await sql`INSERT INTO task_status_part VALUES(${added_id},${part.part_id},${part.quantity})`;
  res.sendStatus(201);
});

router.patch("/:id", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  if (
    !(
      req.body.tstat_id &&
      req.body.task_status.tstat_datetime &&
      req.body.task_status.tstype_id &&
      req.body.task_status_mechanics.length
    )
  )
    return res.sendStatus(400);
  await sql`
    UPDATE task_status
    SET
    tstat_details = ${req.body.task_status.tstat_details},
    tstype_id = ${req.body.task_status.tstype_id}
    WHERE tstat_id = ${req.body.tstat_id};
  `;
  await sql`DELETE FROM task_status_mechanics WHERE tstat_id = ${req.body.tstat_id};`;
  for (mechanic of req.body.task_status_mechanics)
    await sql`INSERT INTO task_status_mechanics VALUES(${req.body.tstat_id},${mechanic})`;
  await sql`DELETE FROM task_status_part WHERE tstat_id = ${req.body.tstat_id};`;
  for (part of req.body.task_status_part)
    await sql`INSERT INTO task_status_part VALUES(${req.body.tstat_id},${part.part_id},${part.quantity})`;
  res.sendStatus(200);
});

router.delete("/:id", async (req, res) => {
  await sql`DELETE FROM tasks WHERE task_id = ${req.params.id}`;
  res.sendStatus(204);
});

router.post("/:id/close", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  try {
    await sql`UPDATE tasks SET task_finished = 1 WHERE task_id = ${req.params.id};`;
    res.sendStatus(200);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/:id/mechanics", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  try {
    const result = await sql`
      SELECT e.emp_id, e.emp_firstname, e.emp_lastname FROM tasks_mechanics tm 
        JOIN employees e ON tm.emp_id = e.emp_id
        WHERE tm.task_id = ${req.params.id};
    `;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.patch("/:id/mechanics", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  if (!req.body.mechanics) return res.sendStatus(400);
  try {
    const injected_sql = `
      DELETE FROM tasks_mechanics
        WHERE task_id = ${+req.params.id}
        AND emp_id NOT IN ("${req.body.mechanics.join('", "')}");
    `;
    await sql([injected_sql]);
    const already_in = await sql`SELECT emp_id FROM tasks_mechanics WHERE task_id = ${+req
      .params.id}`;
    for (mechanic of req.body.mechanics.filter(
      (m) => !already_in.map((a) => a.emp_id).includes(m)
    ))
      await sql`INSERT INTO tasks_mechanics VALUES(${mechanic},${req.params.id});`;
    res.sendStatus(200);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/:id/status", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  try {
    const result = await sql`
      SELECT ts.tstat_id, ts.tstat_datetime, tstype.tstype_name, tspla.part_names, tsmlj.emp_names, ts.tstat_details
        FROM task_status ts
        JOIN task_status_type tstype ON ts.tstype_id = tstype.tstype_id
        LEFT JOIN (
          SELECT tstat_id, GROUP_CONCAT(emp_fullname SEPARATOR ', ') AS emp_names
            FROM (
              SELECT tsm.tstat_id, CONCAT_WS(' ', e.emp_firstname, e.emp_lastname) AS emp_fullname
                FROM task_status_mechanics tsm
                JOIN employees e ON tsm.emp_id = e.emp_id
            ) tast_status_mechanic_list
            GROUP BY tstat_id
        ) tsmlj ON ts.tstat_id = tsmlj.tstat_id
        LEFT JOIN (
          SELECT tstat_id, GROUP_CONCAT(part_name SEPARATOR ', ') AS part_names
            FROM (
              SELECT tsp.tstat_id, p.part_name
                FROM task_status_part tsp
                JOIN parts p ON tsp.part_id = p.part_id
            ) task_status_part_list
            GROUP BY tstat_id
        ) tspla ON ts.tstat_id = tspla.tstat_id
        WHERE task_id = ${req.params.id}
        ORDER BY tstat_datetime;
    `;
    res.json(result);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
});

router.get("/:id/status/:status_id", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  if (isNaN(+req.params.status_id)) return res.sendStatus(400);
  const task_status = await sql`SELECT * FROM task_status WHERE tstat_id = ${req.params.status_id};`;
  const task_status_mechanics = await sql`SELECT * FROM task_status_mechanics WHERE tstat_id = ${req.params.status_id};`;
  const task_status_part = await sql`SELECT * FROM task_status_part WHERE tstat_id = ${req.params.status_id};`;
  const result = {
    task_status: task_status[0],
    task_status_mechanics: task_status_mechanics.map(
      (mechanic) => mechanic.emp_id
    ),
    task_status_part,
  };
  res.json(result);
});

router.delete("/:id/status/:status_id", async (req, res) => {
  if (isNaN(+req.params.id)) return res.sendStatus(400);
  if (isNaN(+req.params.status_id)) return res.sendStatus(400);
  await sql`DELETE FROM task_status WHERE tstat_id = ${req.params.status_id}`;
  res.sendStatus(204);
});

module.exports = router;
