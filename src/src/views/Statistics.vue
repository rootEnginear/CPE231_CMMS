<template>
  <div class="container">
    <div class="spacer is-2x"></div>
    <div class="columns">
      <div class="column">
        <h1 class="title">
          <i class="fas fa-chart-bar"></i>
          สถิติการแจ้งและซ่อมแซมเครื่องจักรในแต่ละเดือน
        </h1>
      </div>
      <div class="column is-narrow">
        <b-button class="is-hidden-print" icon-left="print" @click="print()"
          >พิมพ์</b-button
        >
      </div>
    </div>
    <div class="columns">
      <div class="column">
        <canvas ref="totalChart"></canvas>
      </div>
      <div class="column">
        <canvas ref="ratioChart"></canvas>
      </div>
    </div>
    <div class="table-responsive">
      <table class="table is-striped is-fullwidth">
        <thead>
          <tr>
            <th>เดือน</th>
            <th>จำนวนการแจ้งซ่อม</th>
            <th>ซ่อมเสร็จแล้ว</th>
            <th>%</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(month, index) in data" :key="index">
            <td>{{ fullmonth[index] }}</td>
            <td>{{ month.length }} ครั้ง</td>
            <td>{{ month.filter(f => f.task_finished).length }} ครั้ง</td>
            <td>
              {{
                (
                  (month.filter(f => f.task_finished).length / month.length) *
                    100 || 0
                ).toFixed(2)
              }}%
            </td>
          </tr>
        </tbody>
        <tfoot>
          <tr>
            <td class="has-text-right">รวม</td>
            <td>
              {{ data.map(e => e.length).reduce((a, c) => a + c, 0) }} ครั้ง
            </td>
            <td>
              {{
                data
                  .map(e => e.filter(f => f.task_finished).length)
                  .reduce((a, c) => a + c, 0)
              }}
              ครั้ง
            </td>
            <td>
              {{
                (
                  (data
                    .map(e => e.filter(f => f.task_finished).length)
                    .reduce((a, c) => a + c, 0) /
                    data.map(e => e.length).reduce((a, c) => a + c, 0)) *
                  100
                ).toFixed(2)
              }}%
            </td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</template>

<script>
import { Chart } from "chart.js";
import axios from "axios";
const monthes = [
  "ม.ค.",
  "ก.พ.",
  "มี.ค.",
  "เม.ย.",
  "พ.ค.",
  "มิ.ย.",
  "ก.ค.",
  "ส.ค.",
  "ก.ย.",
  "ต.ค.",
  "พ.ย.",
  "ธ.ค."
];

export default {
  name: "Statistics",
  created() {
    axios
      .get("http://localhost:3000/api/tasks/by_monthes")
      .then(res => {
        this.data = res.data;
      })
      .catch(e => {
        this.$buefy.dialog.alert(
          "เกิดข้อผิดพลาดขึ้น กรุณาลองอีกครั้ง<br>รายละเอียด: " + e.message
        );
      });
  },
  mounted() {
    this.total_chart = new Chart(this.$refs.totalChart, {
      type: "bar",
      data: {
        labels: monthes,
        datasets: [
          {
            label: "จำนวนการแจ้งซ่อม",
            data: this.data.map(e => e.length),
            backgroundColor: "rgba(50, 152, 220, 0.2)",
            borderColor: "rgba(50, 152, 220, 1)",
            borderWidth: 1
          }
        ]
      },
      options: {
        title: {
          display: true,
          text: "จำนวนการแจ้งซ่อมเครื่องจักร"
        },
        legend: {
          position: "bottom"
        },
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true
              }
            }
          ]
        }
      }
    });
    this.ratio_chart = new Chart(this.$refs.ratioChart, {
      type: "bar",
      data: {
        labels: monthes,
        datasets: [
          {
            label: "เสร็จแล้ว",
            data: this.data.map(e => e.filter(f => f.task_finished).length),
            backgroundColor: "rgba(50, 152, 220, 0.2)",
            borderColor: "rgba(50, 152, 220, 1)",
            borderWidth: 1
          },
          {
            label: "ยังไม่เสร็จ",
            data: this.data.map(e => e.filter(f => !f.task_finished).length),
            backgroundColor: "rgba(241, 70, 104, 0.2)",
            borderColor: "rgba(241, 70, 104, 1)",
            borderWidth: 1
          }
        ]
      },
      options: {
        title: {
          display: true,
          text: "อัตราส่วนการซ่อมเครื่องจักร"
        },
        legend: {
          position: "bottom"
        },
        scales: {
          xAxes: [
            {
              stacked: true
            }
          ],
          yAxes: [
            {
              stacked: true,
              ticks: {
                beginAtZero: true
              }
            }
          ]
        }
      }
    });
  },
  data() {
    return {
      fullmonth: [
        "มกราคม",
        "กุมภาพันธ์",
        "มีนาคม",
        "เมษายน",
        "พฤษภาคม",
        "มิถุนายน",
        "กรกฎาคม",
        "สิงหาคม",
        "กันยายน",
        "ตุลาคม",
        "พฤศจิกายน",
        "ธันวาคม"
      ],
      data: [],
      total_chart: null,
      ratio_chart: null
    };
  },
  methods: {
    print() {
      window.print();
    }
  },
  watch: {
    data() {
      this.total_chart.data.datasets[0].data = this.data.map(e => e.length);
      this.ratio_chart.data.datasets[0].data = this.data.map(
        e => (e.filter(f => f.task_finished).length / e.length) * 100
      );
      this.ratio_chart.data.datasets[1].data = this.data.map(
        e => (e.filter(f => !f.task_finished).length / e.length) * 100
      );
      this.total_chart.update();
      this.ratio_chart.update();
    }
  }
};
</script>

<style lang="scss" scoped>
</style>