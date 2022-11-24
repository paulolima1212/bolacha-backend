import { Controller, Req } from '@nestjs/common';
import { UseGuards } from '@nestjs/common/decorators/core/use-guards.decorator';
import { Post } from '@nestjs/common/decorators/http/request-mapping.decorator';
import { AuthGuard } from '@nestjs/passport';

import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @UseGuards(AuthGuard('local'))
  @Post('/login')
  async login(@Req() user: any) {
    const token = await this.authService.login(user);
    const { password, ...rest } = user.user.user;
    return {
      user: rest,
      token,
    };
  }
}
