import { PartialType } from '@nestjs/mapped-types';
import { CreateAuthUserDto } from './createUser.dto';

export class UpdateAuthUserDto extends PartialType(CreateAuthUserDto) {}
