import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, User } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}
  async findUser(
    userWhereUniqueInput: Prisma.UserWhereUniqueInput,
  ): Promise<User | null> {
    return this.prisma.user.findUnique({
      where: userWhereUniqueInput,
    });
  }

  async passwordSet(userEmail: string): Promise<boolean> {
    const user = await this.findUser({ email: userEmail });
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return !!user.password;
  }

  async setPassword(userEmail: string, password: string): Promise<void> {
    const user = await this.findUser({ email: userEmail });
    if (!user) {
      throw new NotFoundException('User not found');
    }
    await this.prisma.user.update({
      where: { email: user.email },
      data: { password },
    });
  }
}
