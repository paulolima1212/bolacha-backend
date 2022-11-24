import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  ParseUUIDPipe,
  HttpStatus,
} from '@nestjs/common';

import { UserService } from './user.service';
import { CreateAuthUserDto } from './dto/createUser.dto';
import { UpdateAuthUserDto } from './dto/updateUser.dto';
import { HttpCode } from '@nestjs/common/decorators/http/http-code.decorator';

@Controller('users')
export class AuthUserController {
  constructor(private readonly userService: UserService) {}

  @Post('/create')
  async store(@Body() createAuthUserDto: CreateAuthUserDto) {
    const user = await this.userService.create(createAuthUserDto);

    return user;
  }

  @Get()
  show() {
    return this.userService.findAll();
  }

  @Patch(':id')
  update(
    @Param('id', new ParseUUIDPipe()) id: string,
    @Body() updateAuthUserDto: UpdateAuthUserDto,
  ) {
    return this.userService.update(id, updateAuthUserDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  destroy(@Param('id', new ParseUUIDPipe()) id: string) {
    return this.userService.remove(id);
  }
}
