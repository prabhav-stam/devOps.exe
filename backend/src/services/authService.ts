import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { User } from '../models/User';

export class AuthService {

    static async register(userData: any) {

        console.log("REGISTER START");

        const { name, email, phone, password, role } = userData;

        console.log("Checking existing user...");

        const existingUser = await User.findOne({ email });

        console.log("Existing user checked");

        if (existingUser) {
            throw new Error('User already exists with this email');
        }

        console.log("Hashing password...");

        const salt = await bcrypt.genSalt(10);
        const passwordHash = await bcrypt.hash(password, salt);

        console.log("Creating user...");

        const newUser = new User({
            name,
            email,
            phone,
            passwordHash,
            role
        });

        console.log("Saving user...");

        await newUser.save();

        console.log("USER SAVED SUCCESSFULLY");

        return {
            message: 'Registration successful'
        };
    }

    static async login(credentials: any) {

        console.log("LOGIN START");

        const { email, password } = credentials;

        console.log("EMAIL ENTERED:", email);
        console.log("PASSWORD ENTERED:", password);

        const user = await User.findOne({ email });

        console.log("USER FOUND:", user);

        if (!user) {
            throw new Error('Invalid credentials');
        }

        console.log("STORED HASH:", user.passwordHash);

        const isMatch = await bcrypt.compare(password, user.passwordHash);

        console.log("PASSWORD MATCH:", isMatch);

        if (!isMatch) {
            throw new Error('Invalid credentials');
        }

        const payload = {
            user: {
                id: user.id,
                email: user.email,
                role: user.role
            }
        };

        const JWT_SECRET = process.env.JWT_SECRET || 'fallback_secret';

        const token = jwt.sign(payload, JWT_SECRET, {
            expiresIn: '5h'
        });

        console.log("LOGIN SUCCESS");

        return {
            token,
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                role: user.role,
                phone: user.phone
            }
        };
    }
}