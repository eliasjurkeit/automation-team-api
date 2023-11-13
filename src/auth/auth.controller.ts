import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Post('login')
  async login(@Body() body: { userEmail: string }) {
    const userEmail = body.userEmail;
    if (!userEmail) {
      throw new BadRequestException('User email is required');
    }
    const passwordSet = await this.authService.passwordSet(userEmail);

    if (!passwordSet) {
      return { status: 'NO_PASSWORD_SET' };
    }
    return { status: 'OK' };
  }

  @Post('set-password')
  async setPassword(@Body() body: { userEmail: string; password: string }) {
    const userEmail = body.userEmail;
    const password = body.password;
    if (!userEmail) {
      throw new BadRequestException('User email is required');
    }
    if (!password) {
      throw new BadRequestException('Password is required');
    }
    await this.authService.setPassword(userEmail, password);
  }
}
