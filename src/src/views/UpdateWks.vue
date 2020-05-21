<template>
  <div class="container">
    <div class="spacer is-2x"></div>
    <div class="columns">
      <div class="column">
        <h1 class="title"><i class="fas fa-wrench"></i> ข้อมูลการแจ้งซ่อม</h1>
      </div>
      <div class="column is-narrow">
        <b-button
          v-if="!task.task_data.task_finished"
          type="is-danger"
          icon-left="clipboard-check"
          @click="markTaskFinished()"
          >ปิดงาน</b-button
        >
      </div>
    </div>
    <div
      v-if="task.task_data.task_finished"
      class="notification is-danger"
      style="background-color:#feecf0;color:#cc0f35"
    >
      งานซ่อมนี้ถูกปิดแล้ว ท่านจะไม่สามารถแก้ไขรายละเอียดใดๆ ได้อีก
    </div>
    <hr />
    <div class="columns">
      <div class="column">
        <div class="field">
          <label class="label">วันเวลาที่แจ้ง</label>
          <div class="control">
            <input v-model="task_datetime" type="text" class="input" readonly />
          </div>
        </div>
      </div>
      <div class="column">
        <div class="field">
          <label class="label">ชื่อผู้แจ้ง</label>
          <div class="control">
            <input
              v-model="task_emp_reporter"
              type="text"
              class="input"
              readonly
            />
          </div>
        </div>
      </div>
    </div>
    <div class="field">
      <label class="label">ชื่อเครื่องจักร</label>
      <div class="control">
        <input
          v-model="task.task_data.mac_name"
          type="text"
          class="input"
          readonly
        />
      </div>
    </div>
    <div class="field">
      <label class="label">รายละเอียด</label>
      <div class="control">
        <textarea
          v-model="task.task_data.task_details"
          class="textarea"
          readonly
        ></textarea>
      </div>
    </div>
    <div>
      <label class="label" style="margin-bottom:0.5em">ผู้รับผิดชอบ</label>
    </div>
    <b-field>
      <b-taginput
        readonly
        expanded
        :closable="false"
        v-model="task_mechanics"
      ></b-taginput>
      <p class="control" v-if="!task.task_data.task_finished">
        <b-button
          icon-left="user-check"
          type="is-info"
          @click="() => (this.is_add_mechanics_modal_open = true)"
          >เลือกผู้รับผิดชอบ</b-button
        >
      </p>
    </b-field>
    <hr />
    <div class="title is-6"><i class="fas fa-list"></i> สถานะการซ่อม</div>
    <div class="table-responsive">
      <table class="table is-striped is-fullwidth">
        <thead>
          <tr>
            <th>วันเวลา</th>
            <th>สถานะ</th>
            <th>ชิ้นส่วน</th>
            <th>ผู้รับผิดชอบ</th>
            <!-- <th>หมายเหตุ</th> -->
            <th>การกระทำ</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(status, index) in task.task_status"
            :key="status.tstat_id"
          >
            <td>{{ new Date(status.tstat_datetime).toLocaleString() }}</td>
            <td>{{ status.tstype_name }}</td>
            <td>
              {{ status.part_names || "-" }}
            </td>
            <td>
              {{ status.emp_names || "-" }}
            </td>
            <!-- <td>{{ status.tstat_details || "-" }}</td> -->
            <td v-if="index">
              <button
                class="button is-info is-small"
                @click="
                  () => {
                    is_info = true;
                    updateData(status.tstat_id);
                  }
                "
              >
                <span class="icon">
                  <i class="fas fa-info"></i>
                </span></button
              >&nbsp;
              <button
                v-if="!task.task_data.task_finished"
                @click="updateData(status.tstat_id)"
                class="button is-warning is-small"
              >
                <span class="icon">
                  <i class="fas fa-pen"></i>
                </span></button
              >&nbsp;
              <button
                v-if="!task.task_data.task_finished"
                class="button is-danger is-small"
                @click="deleteStatus(status.tstat_id)"
              >
                <span class="icon">
                  <i class="fas fa-trash-alt"></i>
                </span>
              </button>
            </td>
            <td v-else>-</td>
          </tr>
          <tr v-if="!task.task_data.task_finished">
            <td colspan="6" class="has-text-centered">
              <button
                class="button is-fullwidth is-success"
                @click="() => (this.is_add_status_modal_open = true)"
              >
                <span class="icon">
                  <i class="fas fa-plus"></i>
                </span>
                <span>เพิ่มสถานะใหม่</span>
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <b-modal
      :active.sync="is_add_mechanics_modal_open"
      scroll="keep"
      @close="updateMechanics()"
    >
      <div class="box">
        <div class="title is-5">
          <i class="fas fa-user-check"></i> เลือกผู้รับผิดชอบ
        </div>
        <b-field label="ผู้รับผิดชอบ">
          <b-taginput
            readonly
            expanded
            :closable="false"
            v-model="task_mechanics"
          ></b-taginput>
        </b-field>
        <b-field label="รายชื่อช่างทั้งหมด" style="margin-bottom:0">
          <div class="control">
            <input
              type="text"
              class="input is-fullwidth"
              style="border-radius:4px 4px 0 0"
              placeholder="ค้นหาช่าง"
              v-model.trim="search_criteria"
            />
          </div>
        </b-field>
        <div
          class="input content"
          style="height:unset;border-radius:0 0 4px 4px;display:block"
        >
          <div v-for="engineer in filtered_engineers" :key="engineer.emp_id">
            <b-checkbox v-model="task.task_mechanics" :native-value="engineer">
              {{ engineer.emp_id.toUpperCase() }} {{ engineer.emp_firstname }}
              {{ engineer.emp_lastname }}
            </b-checkbox>
          </div>
        </div>
      </div>
    </b-modal>

    <b-modal
      :active.sync="is_add_status_modal_open"
      scroll="keep"
      @close="() => (is_info = false)"
    >
      <div class="box">
        <div class="title is-5">
          <i class="fas fa-info-circle"></i>
          {{
            is_info
              ? "รายละเอียดสถานะ"
              : is_edit
              ? "แก้ไขสถานะ"
              : "เพิ่มสถานะใหม่"
          }}
        </div>
        <div class="columns">
          <div class="column is-6">
            <div class="field">
              <label class="label">วันเวลาที่แจ้ง</label>
              <div class="control">
                <input
                  readonly
                  type="text"
                  class="input"
                  :value="new Date(tstat_datetime).toLocaleString()"
                />
              </div>
            </div>
          </div>
          <div class="column is-6">
            <div class="field">
              <label class="label">สถานะ</label>
              <div class="control">
                <div class="select is-fullwidth">
                  <select v-model="tstype_id" v-if="!is_info">
                    <option
                      v-for="status in available_status"
                      :key="status.tstype_id"
                      :value="status.tstype_id"
                    >
                      {{ status.tstype_name }}
                    </option>
                  </select>
                  <input
                    v-else
                    type="text"
                    v-model="
                      available_status.filter(s => s.tstype_id === tstype_id)[0]
                        .tstype_name
                    "
                    class="input is-fullwidth"
                    readonly
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="columns">
          <!-- parts -->
          <div class="column is-6">
            <div class="field">
              <label class="label">อะไหล่ที่ต้องใช้</label>
              <div class="control">
                <div
                  class="input content"
                  style="height:unset;margin-bottom:0;border-radius:4px 4px 0 0"
                >
                  <ul v-if="required_parts.length" style="margin:0;width:100%">
                    <li
                      v-for="(part, index) in required_parts"
                      :key="index"
                      style="display:flex"
                    >
                      <div style="padding-top:4px;flex:1 1 0px">
                        &bull; {{ part.selected_part.part_name }} &times;{{
                          part.quantity
                        }}
                      </div>
                      <div>
                        <b-button
                          icon-left="trash-alt"
                          @click="deleteRequiredPart(index)"
                          type="is-danger"
                          v-if="!is_info"
                        ></b-button>
                      </div>
                    </li>
                  </ul>
                  <div v-else style="margin:4px 0">
                    ไม่มีอะไหล่ที่ต้องใช้
                  </div>
                </div>
                <b-dropdown
                  ref="part_dropdown"
                  aria-role="menu"
                  :disabled="!filtered_parts.length || is_info"
                  trap-focus
                  expanded
                >
                  <button
                    slot="trigger"
                    class="button is-fullwidth is-info"
                    style="border-radius:0 0 4px 4px"
                  >
                    <span class="icon">
                      <i class="fas fa-plus"></i>
                    </span>
                    <span>เพิ่มอะไหล่</span>
                  </button>

                  <b-dropdown-item
                    aria-role="menu-item"
                    :focusable="false"
                    custom
                  >
                    <b-field label="อะไหล่ที่ใช้ได้">
                      <b-select
                        v-model="add_part_compose.selected_part"
                        placeholder="เลือกอะไหล่"
                        @input="() => (add_part_compose.quantity = 0)"
                        expanded
                      >
                        <option
                          v-for="part in filtered_parts"
                          :key="part.part_id"
                          :value="part"
                          >{{ part.part_name }}</option
                        >
                      </b-select>
                    </b-field>
                    <div class="columns">
                      <div class="column">
                        <b-field label="จำนวนที่ใช้">
                          <b-slider
                            :min="0"
                            :max="
                              (add_part_compose.selected_part &&
                                add_part_compose.selected_part.part_quantity) ||
                                0
                            "
                            v-model="add_part_compose.quantity"
                            ticks
                            size="is-medium"
                          ></b-slider>
                        </b-field>
                      </div>
                      <div class="column is-narrow">
                        <div class="field">
                          <div class="spacer is-2x"></div>
                          <b-input
                            type="text"
                            :value="add_part_compose.quantity"
                            style="width:5.5ch"
                            readonly
                          ></b-input>
                        </div>
                      </div>
                    </div>
                    <button
                      class="button is-fullwidth is-success"
                      @click="addPart()"
                    >
                      <span class="icon">
                        <i class="fas fa-plus"></i>
                      </span>
                      <span>เพิ่มอะไหล่</span>
                    </button>
                  </b-dropdown-item>
                </b-dropdown>
              </div>
            </div>
          </div>
          <!-- mechanics -->
          <div class="column is-6">
            <div class="field">
              <label class="label">ผู้รับผิดชอบ</label>
              <div class="control">
                <div
                  class="input content"
                  style="height:unset;margin-bottom:0;border-radius:4px 4px 0 0"
                >
                  <ul
                    v-if="required_mechanics.length"
                    style="margin:0;width:100%"
                  >
                    <li
                      v-for="(mechanic, index) in required_mechanics"
                      :key="index"
                      style="display:flex"
                    >
                      <div style="padding-top:4px;flex:1 1 0px">
                        &bull; {{ mechanic.emp_id.toUpperCase() }}
                        {{ mechanic.emp_firstname }}
                        {{ mechanic.emp_lastname }}
                      </div>
                      <div>
                        <b-button
                          icon-left="trash-alt"
                          @click="deleteRequiredMechanic(index)"
                          type="is-danger"
                          v-if="!is_info"
                        ></b-button>
                      </div>
                    </li>
                  </ul>
                  <div v-else style="margin:4px 0">
                    กรุณาเพิ่มผู้รับผิดชอบ
                  </div>
                </div>
                <b-dropdown
                  position="is-bottom-left"
                  trap-focus
                  aria-role="list"
                  :close-on-click="false"
                  :disabled="is_info"
                  expanded
                >
                  <b-button
                    slot="trigger"
                    expanded
                    icon-left="user-check"
                    type="is-info"
                    style="border-radius:0 0 4px 4px"
                    >เลือกผู้รับผิดชอบ</b-button
                  >

                  <b-dropdown-item
                    aria-role="listitem"
                    v-for="engineer in task.task_mechanics"
                    :key="engineer.emp_id"
                  >
                    <b-checkbox
                      v-model="required_mechanics"
                      :native-value="engineer"
                    >
                      {{ engineer.emp_id.toUpperCase() }}
                      {{ engineer.emp_firstname }}
                      {{ engineer.emp_lastname }}
                    </b-checkbox>
                  </b-dropdown-item>
                </b-dropdown>
              </div>
            </div>
          </div>
        </div>

        <div class="field">
          <label class="label">รายละเอียดเพิ่มเติม (หากมี)</label>
          <div class="control">
            <textarea
              v-model="tstat_details"
              class="textarea"
              placeholder="รายละเอียดเพิ่มเติม"
              :readonly="is_info"
              row="2"
            ></textarea>
          </div>
        </div>

        <section v-if="!is_info">
          <button
            class="button is-fullwidth is-success"
            @click="confirmAddStatus()"
            v-if="!is_edit"
          >
            <span class="icon">
              <i class="fas fa-plus"></i>
            </span>
            <span>เพิ่มข้อมูล</span>
          </button>
          <button
            v-else
            class="button is-fullwidth is-success"
            @click="confirmAddStatus()"
          >
            <span class="icon">
              <i class="fas fa-plus"></i>
            </span>
            <span>อัพเดตข้อมูล</span>
          </button>
        </section>
      </div>
    </b-modal>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "UpdateWks",
  created() {
    this.getData();
    this.getEngineers();
    this.getStatus();
  },
  data() {
    return {
      task: {
        task_data: {
          task_id: null,
          task_finished: 0,
          emp_id_reporter: "",
          emp_firstname: "",
          emp_lastname: "",
          mac_id: null,
          task_details: "",
          tstat_datetime_min: 0
        },
        task_mechanics: [],
        task_status: []
      },
      // Change Engineer modal
      is_add_mechanics_modal_open: false,
      search_criteria: "",
      available_engineers: [],
      // Add status modal data
      is_add_status_modal_open: false,
      is_edit: false,
      is_info: false,
      available_status: [],
      tstat_datetime: +new Date(),
      tstype_id: 2,
      tstat_details: null,
      // Add parts data
      available_parts: [],
      required_parts: [],
      add_part_compose: {
        selected_part: {},
        quantity: 0
      },
      // Add mechanics data
      required_mechanics: []
    };
  },
  computed: {
    task_datetime() {
      return new Date(this.task.task_data.tstat_datetime_min).toLocaleString();
    },
    task_emp_reporter() {
      const {
        emp_id_reporter,
        emp_firstname,
        emp_lastname
      } = this.task.task_data;
      return `${emp_id_reporter.toUpperCase()} ${emp_firstname} ${emp_lastname}`;
    },
    task_mechanics() {
      return this.task.task_mechanics.map(
        ({ emp_id, emp_firstname, emp_lastname }) =>
          `${emp_id.toUpperCase()} ${emp_firstname} ${emp_lastname}`
      );
    },
    filtered_parts() {
      const part_id = this.required_parts.map(
        part => part.selected_part.part_id
      );
      return this.available_parts.filter(
        part => !part_id.includes(part.part_id)
      );
    },
    new_status_summary() {
      return {
        tstat_id: this.is_edit,
        task_status: {
          tstat_datetime: this.tstat_datetime,
          tstat_details: this.tstat_details,
          tstype_id: this.tstype_id
        },
        task_status_mechanics: this.required_mechanics.map(data => data.emp_id),
        task_status_part: this.required_parts.map(data => ({
          part_id: data.selected_part.part_id,
          quantity: data.quantity
        }))
      };
    },
    filtered_engineers() {
      return this.search_criteria
        ? this.available_engineers.filter(
            engie =>
              engie.emp_id.includes(this.search_criteria) ||
              engie.emp_firstname.includes(this.search_criteria) ||
              engie.emp_lastname.includes(this.search_criteria) ||
              `${engie.emp_firstname} ${engie.emp_lastname}`.includes(
                this.search_criteria
              )
          )
        : this.available_engineers;
    }
  },
  methods: {
    getData() {
      const task_id = +this.$route.params.id;
      if (!isNaN(task_id)) {
        axios
          .get(`http://localhost:3000/api/tasks/${task_id}`)
          .then(res => {
            this.task.task_data = res.data;
            this.getParts();
          })
          .catch(e => {
            this.$buefy.dialog.alert(
              "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
            );
          });
        axios
          .get(`http://localhost:3000/api/tasks/${task_id}/mechanics`)
          .then(res => {
            this.task.task_mechanics = res.data;
          })
          .catch(e => {
            this.$buefy.dialog.alert(
              "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
            );
          });
        axios
          .get(`http://localhost:3000/api/tasks/${task_id}/status`)
          .then(res => {
            this.task.task_status = res.data;
          })
          .catch(e => {
            this.$buefy.dialog.alert(
              "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
            );
          });
      }
    },
    getEngineers() {
      axios
        .get(`http://localhost:3000/api/mechanics`)
        .then(res => {
          this.available_engineers = res.data;
        })
        .catch(e => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
          );
        });
    },
    getStatus() {
      axios
        .get(`http://localhost:3000/api/tasks/available_status`)
        .then(res => {
          this.available_status = res.data;
        })
        .catch(e => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
          );
        });
    },
    getParts() {
      axios
        .get(
          `http://localhost:3000/api/machines/${this.task.task_data.mac_id}/parts`
        )
        .then(res => {
          this.available_parts = res.data;
          this.add_part_compose.selected_part = this.filtered_parts[0];
        })
        .catch(e => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
          );
        });
    },
    addPart() {
      if (!this.add_part_compose.selected_part) {
        this.$buefy.dialog.alert("กรุณาระบุอะไหล่");
      } else if (this.add_part_compose.quantity === 0) {
        this.$buefy.dialog.alert("กรุณาระบุอย่างน้อย 1 ชิ้น");
      } else {
        this.$refs.part_dropdown.toggle();
        this.required_parts.push(this.add_part_compose);
        this.add_part_compose = {
          selected_part: this.filtered_parts[0],
          quantity: 0
        };
      }
    },
    deleteRequiredPart(index) {
      this.required_parts.splice(index, 1);
    },
    deleteRequiredMechanic(index) {
      this.required_mechanics.splice(index, 1);
    },
    confirmAddStatus() {
      if (!this.required_mechanics.length) {
        this.$buefy.dialog.alert("กรุณาเพิ่มผู้รับผิดชอบ");
      } else {
        this.$buefy.dialog.confirm({
          title: "กรุณาตรวจสอบความถูกต้อง",
          message: `
            <section class="content">
              <b>วันเวลาที่แจ้ง</b>: ${new Date(
                this.tstat_datetime
              ).toLocaleString()}<br />
              <b>สถานะ</b>: ${
                this.available_status.filter(
                  status => status.tstype_id === this.tstype_id
                )[0].tstype_name
              }<br />
              ${
                this.required_parts.length
                  ? `
                <b>อะไหล่ที่ต้องใช้</b>:<br />
                <ul style="margin:0 0 0 32px">
                  ${this.required_parts
                    .map(
                      data =>
                        `<li>${data.selected_part.part_name} &times;${data.quantity}</li>`
                    )
                    .join("")}
                </ul>
              `
                  : ""
              }
              <b>ผู้รับผิดชอบ</b>:<br />
              <ul style="margin:0 0 0 32px">
                ${this.required_mechanics
                  .map(
                    data =>
                      `<li>${data.emp_id.toUpperCase()} ${data.emp_firstname} ${
                        data.emp_lastname
                      }</li>`
                  )
                  .join("")}
              </ul>
              <b>รายละเอียดอื่นๆ</b>: ${this.tstat_details || "-"}<br />
            </section>
          `,
          cancelText: "กลับไปแก้ไข",
          confirmText: "ยืนยัน",
          type: "is-success",
          onConfirm: () => {
            this.is_add_status_modal_open = false;
            axios[this.is_edit ? "patch" : "post"](
              `http://localhost:3000/api/tasks/${this.$route.params.id}`,
              this.new_status_summary
            )
              .then(res => {
                this.$buefy.dialog.alert(
                  ["อัพเดตข้อมูลสำเร็จ!", "เพิ่มข้อมูลสำเร็จ!"][
                    res.status - 200
                  ]
                );
                this.is_add_status_modal_open = false;
                this.tstat_details = null;
                this.tstype_id = 2;
                this.required_mechanics = [];
                this.required_parts = [];
                this.getData();
              })
              .catch(err => {
                this.$buefy.dialog.alert(
                  "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " +
                    err.message
                );
              });
          }
        });
      }
    },
    updateData(tstat_id) {
      axios
        .get(
          `http://localhost:3000/api/tasks/${this.$route.params.id}/status/${tstat_id}`
        )
        .then(res => {
          this.is_add_status_modal_open = true;
          this.$nextTick(() => {
            this.tstat_details = res.data.task_status.tstat_details;
            this.tstype_id = res.data.task_status.tstype_id;
            this.required_mechanics = this.available_engineers.filter(engie =>
              res.data.task_status_mechanics.includes(engie.emp_id)
            );
            this.required_parts = res.data.task_status_part.map(part => ({
              ...part,
              selected_part: this.available_parts.filter(
                a_part => a_part.part_id === part.part_id
              )[0]
            }));
            this.is_edit = tstat_id;
            this.tstat_datetime = res.data.task_status.tstat_datetime;
          });
        })
        .catch(e => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
          );
        });
    },
    deleteStatus(tstat_id) {
      this.$buefy.dialog.confirm({
        message:
          "ต้องการลบสถานะนี้จริงๆ หรือไม่?<br />ท่านจะ<b>ไม่สามารถ</b>กู้คืนข้อมูลนี้ได้อีก",
        onConfirm: () => {
          axios
            .delete(
              `http://localhost:3000/api/tasks/${this.$route.params.id}/status/${tstat_id}`
            )
            .then(res => {
              if (res.status === 204) {
                this.$buefy.dialog.alert("ลบข้อมูลสำเร็จ!");
                this.getData();
              }
            })
            .catch(err => {
              this.$buefy.dialog.alert(
                "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " +
                  err.message
              );
            });
        }
      });
    },
    updateMechanics() {
      axios
        .patch(
          `http://localhost:3000/api/tasks/${this.$route.params.id}/mechanics`,
          { mechanics: this.task.task_mechanics.map(m => m.emp_id) }
        )
        .then(res => {
          res;
          this.getData();
        })
        .catch(err => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + err.message
          );
        });
    },
    markTaskFinished() {
      this.$buefy.dialog.confirm({
        message:
          'ต้องการปิดงานนี้จริงๆ หรือไม่?<br />งานนี้จะมีสถานะเป็น "สำเร็จ" และท่านจะ<b>ไม่สามารถแก้ไขข้อมูล</b>ได้อีก กรุณาตรวจสอบรายละเอียดอีกครั้งก่อนปิดงาน',
        onConfirm: () => {
          axios
            .post(
              `http://localhost:3000/api/tasks/${this.$route.params.id}/close`
            )
            .then(res => {
              if (res.status === 200) {
                this.$buefy.dialog.alert("ปิดงานสำเร็จ!");
                this.getData();
              }
            })
            .catch(err => {
              this.$buefy.dialog.alert(
                "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " +
                  err.message
              );
            });
        }
      });
    }
  },
  watch: {
    is_add_status_modal_open(val) {
      if (val) {
        this.getStatus();
        this.getParts();
        if (this.is_edit) {
          this.tstat_details = null;
          this.tstype_id = 2;
          this.required_mechanics = [];
          this.required_parts = [];
          this.is_edit = false;
        }
        this.tstat_datetime = +new Date();
      }
    }
  }
};
</script>