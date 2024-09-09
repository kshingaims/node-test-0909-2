module.exports = {
  apps: [
    {
      name: 'mctrip',
      watch: false,
      script: './dist/server.js',
      exec_mode: 'cluster',
      instances: process.env.PM2_INSTANCES || '2',
      wait_ready: true,
      env_development: {
        NODE_ENV: 'development',
      },
      env_production: {
        NODE_ENV: 'production',
      },
      env_staging: {
        NODE_ENV: 'staging',
      },
      env_demo: {
        NODE_ENV: 'staging_suuiiisya',
      },
    },
  ],
};
