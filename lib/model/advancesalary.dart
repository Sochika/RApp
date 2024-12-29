
class AdvanceSalary{
  int id;
  String? description;
  String requested_amount;
  String released_amount;
  String status;
  bool is_settled;
  String? verifiedBy;
  String? remark;
  String submittedDate;

  AdvanceSalary(
      this.id,
      this.description,
      this.requested_amount,
      this.released_amount,
      this.status,
      this.is_settled,
      this.verifiedBy,
      this.remark,
      this.submittedDate);
}