import axios from 'axios'

const api = function (){
    return axios.create({
        baseURL: window.location.origin,
        timeout: 60000,
        headers: {
            'X-CSRF-Token' : document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
    });
}

export default api;