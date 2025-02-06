<script>
  import "../index.scss";
  import { idlFactory, canisterId } from 'declarations/internet_identity_backend';
  import { writable } from 'svelte/store';
  import { AuthClient } from "@dfinity/auth-client";
  import { HttpAgent, Actor } from "@dfinity/agent";

  let principal = writable("");

  async function login() {
    try {
        const authClient = await AuthClient.create({
            idleOptions: {
                idleTimeout: 1000 * 60 * 30,
                disableDefaultIdleCallback: true
            }
        });

        const isLocal = process.env.DFX_NETWORK !== "ic";
        const identityProvider = isLocal
            ? "http://rdmx6-jaaaa-aaaaa-aaadq-cai.localhost:8080"
            : "https://identity.ic0.app";

        await authClient.login({
            identityProvider,
            maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000),
            onSuccess: async () => {
                try {
                    console.log("Authentication successful!");

                    const identity = await authClient.getIdentity();
                    const agent = await HttpAgent.create({
                        identity,
                        host: isLocal ? "http://127.0.0.1:8080" : "https://ic0.app",
                    });

                    if (isLocal) {
                        await agent.fetchRootKey();
                    }

                    const actor = Actor.createActor(idlFactory, { agent, canisterId });

                    const principalResult = await actor.whoami();
                    principal.set(principalResult);
                } catch (error) {
                    console.error("Error after authentication:", error);
                }
            },
            onError: (err) => {
                console.error("Authentication failed:", err);
            }
        });

    } catch (error) {
        console.error("Unexpected error during login:", error);
    }
}
</script>

<main class="flex flex-col items-center justify-center p-4">
  <img src="/logo2.svg" alt="DFINITY logo" class="mb-8" />
  
  <form on:submit|preventDefault>
    <button 
      type="button"
      on:click={login}
      class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
    >
      Login with Internet Identity
    </button>
  </form>

  {#if $principal}
    <section class="mt-4 p-4 bg-gray-100 rounded">
      <p>Principal ID: {$principal}</p>
    </section>
  {/if}
</main>
