// client/src/api.js
const base = import.meta.env.VITE_API_BASE || '/api';


export async function login(username,password){
const r=await fetch(base+'/auth/login',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({username,password})});
return r.json();
}
