# Notification Configuration Guide

This workflow supports multiple notification methods when builds fail. Configure them by adding secrets to your GitHub repository.

## Available Notifications

### 1. PR Comments (Automatic)
- **Status**: Enabled by default
- **When**: Automatically comments on PRs when workflow fails
- **Configuration**: No setup required

### 2. Email Notifications (Optional)
- **Status**: Requires configuration
- **When**: Sends email when workflow fails
- **Required Secrets**:
  - `SMTP_SERVER` - SMTP server address (e.g., `smtp.gmail.com`)
  - `SMTP_PORT` - SMTP server port (e.g., `587` for TLS, `465` for SSL)
  - `SMTP_USERNAME` - SMTP username/email
  - `SMTP_PASSWORD` - SMTP password or app password
  - `SMTP_FROM` - From email address
  - `NOTIFICATION_EMAIL` - Recipient email address

**Example Setup (Gmail)**:
1. Go to Repository Settings → Secrets and variables → Actions
2. Add secrets:
   - `SMTP_SERVER`: `smtp.gmail.com`
   - `SMTP_PORT`: `587`
   - `SMTP_USERNAME`: `your-email@gmail.com`
   - `SMTP_PASSWORD`: `your-app-password` (use App Password, not regular password)
   - `SMTP_FROM`: `your-email@gmail.com`
   - `NOTIFICATION_EMAIL`: `notify@example.com`

### 3. Slack Notifications (Optional)
- **Status**: Requires configuration
- **When**: Sends Slack message when workflow fails
- **Required Secret**:
  - `SLACK_WEBHOOK_URL` - Slack Incoming Webhook URL

**Example Setup**:
1. Go to https://api.slack.com/apps
2. Create a new app or select existing app
3. Go to "Incoming Webhooks" → Activate Incoming Webhooks
4. Add New Webhook to Workspace → Select channel
5. Copy the webhook URL
6. Go to Repository Settings → Secrets and variables → Actions
7. Add secret `SLACK_WEBHOOK_URL` with the webhook URL

## Testing Notifications

To test notifications, you can temporarily make the workflow fail by adding a failing step, or wait for an actual failure.

## Disabling Notifications

To disable email or Slack notifications, simply don't set the corresponding secrets. The workflow will skip those notification steps automatically.

