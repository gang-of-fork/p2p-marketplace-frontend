import { writable } from "svelte/store";
export const jwt = writable("");
export const userAddress = writable("");
export const BACKEND_SERVER = "https://api.plantexchange.gang-of-fork.de/api/v1";