<template>
  <div class="container">
    <div class="spacer is-2x"></div>
    <div class="columns">
      <div class="column">
        <h1 class="title"><i class="fas fa-wrench"></i> รายการแจ้งซ่อม</h1>
      </div>
      <div class="column is-narrow">
        <div style="margin:.375rem .75rem;display:inline-block">
          <b-checkbox v-model="show_all">แสดงงานทั้งหมด</b-checkbox>
        </div>
        <b-button icon-left="sync" @click="fetchWorks()"
          >โหลดข้อมูลใหม่</b-button
        >
      </div>
    </div>

    <div class="table-responsive">
      <b-table
        :data="filtered_works"
        ref="workstable"
        hoverable
        :loading="isLoadingWorks"
        :mobile-cards="false"
      >
        <template slot-scope="props">
          <b-table-column field="task_id" label="#">{{
            props.row.task_id
          }}</b-table-column>
          <b-table-column field="emp_id_reporter" label="รหัสพนักงาน">{{
            props.row.emp_id_reporter.toUpperCase()
          }}</b-table-column>
          <b-table-column field="emp_firstname" label="ชื่อ">{{
            `${props.row.emp_firstname} ${props.row.emp_lastname}`
          }}</b-table-column>
          <b-table-column field="tstat_datetime" label="วันที่แจ้ง">{{
            new Date(props.row.tstat_datetime).toLocaleString()
          }}</b-table-column>
          <b-table-column field="tstype_name" label="สถานะงานล่าสุด">
            <div
              class="tag is-success is-medium"
              v-if="props.row.task_finished"
            >
              <i class="fas fa-check" style="margin-right:.5ch"></i>ปิดงานแล้ว
            </div>
            <div class="tag is-warning is-medium" v-else>
              <i class="fas fa-tasks" style="margin-right:.5ch"></i
              >{{ props.row.tstype_name }}
            </div>
          </b-table-column>
          <b-table-column label="">
            <b-button
              icon-left="info-circle"
              @click.prevent="editTask(props.row.task_id)"
              >ดูรายละเอียดงาน</b-button
            >
          </b-table-column>
        </template>

        <template slot="empty">
          <section class="section">
            <div class="content has-text-grey has-text-centered">
              <p>¯\_(ツ)_/¯ ไม่มีงานซ่อมใดๆ</p>
            </div>
          </section>
        </template>
      </b-table>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Home",
  created() {
    this.fetchWorks();
  },
  data() {
    return {
      isLoadingWorks: true,
      works: [],
      show_all: false
    };
  },
  computed: {
    filtered_works() {
      return this.show_all
        ? this.works
        : this.works.filter(work => !work.task_finished);
    }
  },
  methods: {
    fetchWorks() {
      this.isLoadingWorks = true;
      axios
        .get("http://localhost:3000/api/tasks")
        .then(res => {
          this.works = res.data;
          this.isLoadingWorks = false;
        })
        .catch(e => {
          this.$buefy.dialog.alert(
            "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
          );
        });
    },
    toggleDetail(row) {
      this.$refs.workstable.toggleDetails(row);
    },
    editTask(id) {
      this.$router.push(`/works/update/${id}`);
    },
    deleteTask(task_id) {
      this.$buefy.dialog.confirm({
        message:
          "ต้องการลบงานซ่อมนี้จริงๆ หรือไม่?<br />ท่านจะ<b>ไม่สามารถ</b>กู้คืนข้อมูลนี้ได้อีก",
        onConfirm: () => {
          axios
            .delete(`http://localhost:3000/api/tasks/${task_id}`)
            .then(res => {
              if (res.status === 204) {
                this.$buefy.dialog.alert("ลบข้อมูลสำเร็จ!");
                this.fetchWorks();
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
  }
};
</script>