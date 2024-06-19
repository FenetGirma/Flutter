abstract class AddSalonEvent {}

class SubmitSalonForm extends AddSalonEvent {
  final String accessToken;

  SubmitSalonForm(this.accessToken);
}
