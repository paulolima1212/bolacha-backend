import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { AuthUserController } from './user.controller';

import { PrismaService } from '../prisma/prisma.service';

@Module({
  controllers: [AuthUserController],
  providers: [UserService, PrismaService],
  exports: [UserService],
})
export class UserModule {}
