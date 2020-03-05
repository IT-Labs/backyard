// This serves for dynamic generation of the emails for new users signups

import * as localstringRandomizer from "./string.helper";

/**
 * Input entire email as string, eg tester@api.com
 *  and get back randomized version, eg tester+_COMPANY_125AB333@api.com
 * @param inputEmail
 */
const randomizeTheEmail = (inputEmail: string): string => {
  const localPart = inputEmail.substring(0, inputEmail.indexOf("@"));
  const randomizedPrepend = randomizeEmailPrepend(localPart);
  const emaildomain = inputEmail.substring(
    inputEmail.indexOf("@"),
    inputEmail.length
  );
  return (randomizedPrepend + emaildomain).toLowerCase();
};

/**
 *
 *
 * Throws error if input (local-part) contains @ anywhere except last character
 * @param inputEmailPrepend
 */
const randomizeEmailPrepend = (inputEmailPrepend: string): string => {
  //check for @ symbol
  var whereAt = inputEmailPrepend.indexOf("@");
  if (inputEmailPrepend.length < 1)
    throw new Error("Empty Argument for localPart of Email");
  else if (whereAt > -1 && whereAt !== inputEmailPrepend.length - 1)
    throw new Error(
      "Cannot randomize email name with @ symbol in beginning or middle"
    );
  else if (whereAt > -1 && whereAt === inputEmailPrepend.length - 1)
    inputEmailPrepend = inputEmailPrepend.substring(
      0,
      inputEmailPrepend.length - 1
    );
  var prependReturn =
    inputEmailPrepend +
    "+_" +
    localstringRandomizer.getRandomString(5);
  return prependReturn;
};

/**
 *
 * Remove white space in begin, middle, or end of string
 * @param inString
 *
 */
function noSpaces(inString: string) {
  return inString.replace(/\s+/g, "");
}

interface EmailGenParams {
  localPrepend: string;
  domain: string;
  label?: string;
}

function generate_email_optional_label({
  localPrepend,
  domain,
  label
}: EmailGenParams): string {
  if (domain[0] !== "@") domain = "@" + domain;
  label = label ? "_" + label : "";
  return localPrepend + label + domain;
}

export {
  randomizeTheEmail,
  randomizeEmailPrepend,
  generate_email_optional_label
};
