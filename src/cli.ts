import { Command } from 'commander';
import { execSync } from 'child_process';
import * as process from 'process';

const program = new Command();

program.command('demo').action(() => {
  try {
    console.log('Validating and Formatting Prisma Schema...');
    execSync('npx prisma format', { stdio: 'inherit' });

    console.log('Generating Prisma Client...');
    execSync('npx prisma generate', { stdio: 'inherit' });

    console.log('Starting MariaDB...');
    execSync('sudo docker compose up -d', { stdio: 'inherit' });

    console.log('Priming Database...');
    execSync(
      'npx prisma db push --skip-generate --force-reset --accept-data-loss',
      { stdio: 'inherit' },
    );
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
});
program.parse(process.argv);
