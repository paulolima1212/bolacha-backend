import {
  IsEmail,
  IsNotEmpty,
  IsString,
  Matches,
  MinLength,
} from 'class-validator';
import { RegexHelper } from '../../helpers/password.helper';

export class CreateAuthUserDto {
  @IsNotEmpty()
  @IsEmail()
  public email: string;

  @IsNotEmpty()
  @IsString()
  public username: string;

  @IsNotEmpty()
  @IsString()
  // @MinLength(8)
  // @Matches(RegexHelper.password)
  public password: string;
}
