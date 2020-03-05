import * as fecha from 'fecha';

/**
 * Create a Date object in UTC timezone
 *
 * @method create
 * @param {string} dateStr Date string in YYYY-MM-DD format
 * @return {Date|boolean}
 */
const create = (dateStr: string): boolean | Date => {
  return fecha.parse(`${dateStr} Z`, 'YYYY-MM-DD ZZ');
};

/**
 * Parse a date string into an object in UTC timezone
 *
 * @method parseUkDate
 * @param {string} dateStr Date string
 * @return {Date|boolean}
 */
const parseUkDate = (dateStr: string): boolean | Date => {
  return fecha.parse(`${dateStr} Z`, `${fecha.masks.ukDate} ZZ`);
};

/**
 * Format a date in UK date format dd/mm/yyyy
 *
 * @method formatUkDate
 * @param {Date|number} dateObj
 * @return {string}
 */
const formatUkDate = (dateObj): string => {
  return fecha.format(dateObj, 'ukDate');
};

/**
 * Returns a current Date object in UTC timezone
 *
 * @method getCurrentDate
 * @return {Date}
 */
const getCurrentDate = (): Date => {
  const now = new Date();
  return new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate()));
};

// module.exports =
export { create, parseUkDate, formatUkDate, getCurrentDate };
