import Vue from "vue";
import Buefy from "buefy";

Vue.use(Buefy, {
  defaultIconPack: "fa",
  defaultDayNames: ["อา", "จ", "อ", "พ", "พฤ", "ศ", "ส"],
  defaultMonthNames: [
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
  defaultDialogConfirmText: "ตกลง",
  defaultDialogCancelText: "ยกเลิก"
});
