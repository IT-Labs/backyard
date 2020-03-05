export function stringToBoolean(val) {
  if (val === '') return null;
  if (val === 'true') return true;
  return false;
}
