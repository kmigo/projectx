
class FilterUser {
  final String? name;
  final String? phoneNumber;
  final String? phoneNumberCurrentUser;
  FilterUser({
    this.name,
    this.phoneNumber,
    this.phoneNumberCurrentUser,
  });

  FilterUser copyWith({
    String? name,
    String? phoneNumber,
    String? phoneNumberCurrentUser,
  }) {
    return FilterUser(
      name: name ?? this.name,
      phoneNumberCurrentUser:
          phoneNumberCurrentUser ?? this.phoneNumberCurrentUser,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
