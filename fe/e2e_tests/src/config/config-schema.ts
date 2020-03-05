import { Schema } from 'jsonschema';
import { Validator } from 'jsonschema';

const emailSchema: Schema = {
  id: '/Email',
  type: 'object',
  properties: {
    prepend: { type: 'string' },
    domain: { type: 'string' },
    password: { type: 'string' },
  },
  required: ['prepend', 'domain', 'password'],
};



export const configSchema: Schema = {
  properties: {
    hostIDP: { type: 'string' },
    url: { type: 'string' }  
  }
 
};

export const schemaValidator = new Validator();
schemaValidator.addSchema(emailSchema, '/Email');
schemaValidator.addSchema(configSchema, '/Config');
