class AddSalonState {
  final String uploadedImagePath;
  final bool isLoading;

  AddSalonState({required this.uploadedImagePath, required this.isLoading});

  AddSalonState copyWith({String? uploadedImagePath, bool? isLoading}) {
    return AddSalonState(
      uploadedImagePath: uploadedImagePath ?? this.uploadedImagePath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
