import * as mongoose from 'mongoose';

export const AppointmentSchema = new mongoose.Schema({
    comment: {
        type: String,
        required: [true, 'An appointment must have a name'],  
        trim: true
    },
    hairstyle: { type: String}, // Adjust if relevant to appointments
    date: {
        type: String,
        required: [true, 'An appointment must have a location']
    },
    time: {
        type:String,
        required: [true ,'provide the time']
    }

    // Add other fields relevant to appointments
});


