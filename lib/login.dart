class Login {
  String? tokenType;
  String? accessToken;
  int? expiresIn;
  String? refreshToken;

  Login({this.tokenType, this.accessToken, this.expiresIn, this.refreshToken});

  Login.fromJson(Map<String, dynamic> json) {
    tokenType = json['tokenType'];
    accessToken = json['accessToken'];
    expiresIn = json['expiresIn'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenType'] = tokenType;
    data['accessToken'] = accessToken;
    data['expiresIn'] = expiresIn;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
