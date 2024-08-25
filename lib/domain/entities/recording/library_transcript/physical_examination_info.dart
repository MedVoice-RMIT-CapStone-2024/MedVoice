class PhysicalExaminationInfo {
  String? mBloodPressure = "";
  String? mPulseRate = "";
  String? mTemperature = "";

  PhysicalExaminationInfo(this.mBloodPressure, this.mPulseRate, this.mTemperature);
  PhysicalExaminationInfo.buildDefault();
}