import { Injectable } from '@nestjs/common';
import { UserService } from '../user/user.service';
import { verify } from 'argon2';
import { JwtService } from '@nestjs/jwt';
import { User } from '@prisma/client';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async validate(email: string, password: string) {
    try {
      const user = await this.userService.findOne(email);

      const isPasswordUser = await verify(user.password, password);

      if (!isPasswordUser) return null;

      return user;
    } catch (err) {
      return null;
    }
  }

  async login(user: Partial<User>) {
    const payload = { sub: user.id, at: user.username };

    return this.jwtService.sign(payload, { expiresIn: '2hours' });
  }
}
