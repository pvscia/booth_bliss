class FrameModel{
  String frameUrl;
  int idx;

  FrameModel(
      {required this.frameUrl,
        required this.idx});

  Map<String, dynamic> toJson() {
    return {
      'frameURl': frameUrl,
      'idx': idx,
    };
  }
}