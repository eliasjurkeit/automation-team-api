import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Social, User } from '@prisma/client';
import * as dotenv from 'dotenv';

@Injectable()
export class InitializeService implements OnModuleInit {
  private readonly setupUserEmail: string;
  private readonly teamMailBox: string;
  private readonly linkedinProfile: string;
  private readonly youtubeProfile: string;
  private readonly instagramProfile: string;
  constructor(private readonly prisma: PrismaService) {
    dotenv.config();
    this.setupUserEmail = process.env.SETUP_USER || '';
    this.teamMailBox = process.env.TEAM_MAILBOX || '';
    this.linkedinProfile = process.env.LINKEDIN_PROFILE || '';
    this.youtubeProfile = process.env.YOUTUBE_PROFILE || '';
    this.instagramProfile = process.env.INSTAGRAM_PROFILE || '';
  }

  async onModuleInit() {
    await this.initializeSetupUser();
    await this.initializeSocials();
  }

  private async initializeSetupUser(): Promise<User> {
    return this.prisma.user.create({
      data: {
        email: this.setupUserEmail,
        userViewAccess: true,
        teamViewAccess: true,
        blogViewAccess: true,
        projectViewAccess: true,
        socialsViewAccess: true,
        featureViewAccess: true,
        auditTrailViewAccess: true,
        assetViewAccess: true,
      },
    });
  }

  private async initializeSocials(): Promise<Social[]> {
    const socials: Social[] = [
      { name: 'Team-Mailbox', value: this.teamMailBox },
      { name: 'LinkedIn', value: this.linkedinProfile },
      { name: 'YouTube', value: this.youtubeProfile },
      { name: 'Instagram', value: this.instagramProfile },
    ];
    return Promise.all(
      socials.map((social) => this.prisma.social.create({ data: social })),
    );
  }
}
