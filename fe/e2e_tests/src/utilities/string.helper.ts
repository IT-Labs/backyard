/**
 * Create random text with the specified length from the set of characters.
 *
 * In step definition it may be used in the following way:
 * > const stringRandomizer=require('../utilities/string.helper');
 *
 * @param characterLength
 * @returns {string}
 */
export const getRandomString = (characterLength: number): string => {
  let randomText = '';
  const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  for (let i = 0; i < characterLength; i += 1) {
    randomText += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return randomText;
};
