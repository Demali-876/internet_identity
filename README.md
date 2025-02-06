# Internet Identity Integration

This repo is a forkable example designed to help you seamlessly implement Internet Identity authentication into your projects.

---

## Getting Started

### 1. Clone or Fork the Repository

```bash
git clone https://github.com/your-username/internet-identity-integration.git
cd internet-identity-integration
```

### 2. Prerequisites

Ensure you have the following installed:

- **Node.js**
- **Internet Computer SDK (IC SDK)**

### 3. Install Dependencies

```bash
npm install
```

### 4. Start the Local DFX Replica

Run the following command to start your local Internet Computer replica:

```bash
dfx start --clean --background
```

**Note:** Take note of the port the replica is running on, e.g., `Replica API running on 127.0.0.1:8080`.

### 5. Create the Internet Identity Canister

```bash
dfx canister create internet_identity --specified-id rdmx6-jaaaa-aaaaa-aaadq-cai
```

### 6. Deploy Canisters

This will create and deploy the backend, frontend, and Internet Identity canisters:

```bash
dfx deploy
```

### 7. View the Application

After deployment, you can view the application at:

- `http://127.0.0.1:8080/?canisterId=yourcanisterid`
- `http://yourcanisterid.localhost:8080/`

---

## Testing the Integration

1. **Run the application:**
   - Open your browser and go to:
     - `http://127.0.0.1:8080/?canisterId=yourcanisterid`
     - `http://yourcanisterid.localhost:8080/`

2. **Click "Login"** to authenticate via Internet Identity.

3. **Verify your principal** appears after successful login.


If you encounter `ECONNREFUSED 127.0.0.1:4943` or a similar error, modify the code to use the port number specified in your **Replica API running on 127.0.0.1:8080**.


Happy building with Internet Identity!


