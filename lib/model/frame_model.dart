class FrameModel{
  String frameURl;
  int idx;

  FrameModel(
      {required this.frameURl,
        required this.idx});

  Map<String, dynamic> toJson() {
    return {
      'frameURl': frameURl,
      'idx': idx,
    };
  }
}