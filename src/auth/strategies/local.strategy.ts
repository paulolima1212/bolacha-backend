import { Strategy } from 'passport-local';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

import { AuthService } from '../auth.service';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(
    private authService: AuthService,
    private jwtService: JwtService,
  ) {
    super({
      usernameField: 'email',
    });
  }

  async validate(email: string, password: string) {
    const user = await this.authService.validate(email, password);

    if (!user) throw new UnauthorizedException('Email ou senha inválidos');

    const payload = { user: user.username, sub: user.id };

    const token = this.jwtService.sign(payload);

    return {
      user,
      token,
    };
  }
}
