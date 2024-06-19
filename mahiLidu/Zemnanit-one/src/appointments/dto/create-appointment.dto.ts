export class CreateAppointmentDto {
    readonly time: string;
    readonly hairstyle: string;  // If this property is relevant for appointments
    readonly comment: string;  
    readonly date : string; 
      // If this property is relevant for appointments
    // Add other appointment-specific properties here
}
