import { Module } from '@nestjs/common';
import { LocalStrategy } from './strategies/local.strategy';

import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { UserService } from '../user/user.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { JwtStrategy } from './strategies/jwt.strategy';

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.SECRET_KEY,
      signOptions: { expiresIn: '2hours' },
    }),
  ],
  providers: [
    LocalStrategy,
    AuthService,
    UserService,
    PrismaService,
    JwtStrategy,
  ],
  controllers: [AuthController],
})
export class AuthModule {}
