import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaService } from './prisma/prisma.service';
import { InitializeService } from './initialize/initialize.service';

@Module({
  imports: [],
  controllers: [AppController],
  providers: [AppService, PrismaService, InitializeService],
})
export class AppModule {}
