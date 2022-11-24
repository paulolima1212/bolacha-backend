import { Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { hash } from 'argon2';

import { CreateAuthUserDto } from './dto/createUser.dto';
import { UpdateAuthUserDto } from './dto/updateUser.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UserService {
  constructor(private readonly prismaService: PrismaService) {}

  async create({ email, password, username }: CreateAuthUserDto) {
    try{
      const passwordHashed = await hash(password);

      const { password: _, ...user } =
        await this.prismaService.user.create({
          data: {
            email,
            username,
            password: passwordHashed,
          },
        });
  
      return user;
    }catch(err){
      console.log(err)

      throw new InternalServerErrorException(err)
    }
  }

  findAll() {
    try{
      return this.prismaService.user.findMany();
    }catch(err){
      console.log(err)
      throw new InternalServerErrorException(err)
    }
  }

  async findOne(email: string) {
    try{
      const user = await this.prismaService.user.findUniqueOrThrow({
        where: {
          email,
        },
      });
  
      return user;
    }catch(err){
      console.log(err)
      throw new NotFoundException(err)
    }
  }

  async update(id: string, updateAuthUserDto: UpdateAuthUserDto) {

    try{
      const { password, ...user } = await this.prismaService.user.update({
        where: {
          id,
        },
        data: updateAuthUserDto,
      });
  
      return user;
    }catch(err){
      console.log(err)
      throw new InternalServerErrorException(err)
    }

  }

  async remove(id: string) {
    try{
      await this.prismaService.user.delete({
        where: {
          id,
        },
      });
    }catch(err){
      console.log(err)
      throw new InternalServerErrorException(err)
    }
  }
}
