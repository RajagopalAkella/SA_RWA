import { LightningElement } from 'lwc';
import promptResp from '@salesforce/apex/SArwaUtilityCls.rwlCheckAudit';

export default class HelloWorld extends LightningElement {
    prompt = 'Hi there!';
    response = '';

    handlePromptChange(event) {
        this.prompt = event.target.value;
    }

    handleClick(event) {
        this.response = 'Working…';
        promptResp({ prompt: this.prompt })
		.then(result => {
			this.response = result;
			this.error = undefined;
		})
		.catch(error => {
            this.response = 'Error';
			this.error = error;
		})
    }
}