export function transformDate(mydate) {
  mydate = new Date(mydate);
  var curr_date = mydate.getDate();
  var curr_month = m_names(mydate.getMonth());
  var curr_year = mydate.getFullYear();

  var mydatestr =
    curr_month +
    ',' +
    curr_date +
    ',' +
    curr_year +
    ' ' +
    mydate.getHours() +
    ':' +
    mydate.getMinutes();
  return mydatestr;
}

export function m_names(myMonth: any) {
  var month = new Array();
  month[0] = 'Jan';
  month[1] = 'Feb';
  month[2] = 'Mar';
  month[3] = 'Apr';
  month[4] = 'May';
  month[5] = 'Jun';
  month[6] = 'Jul';
  month[7] = 'Aug';
  month[8] = 'Sep';
  month[9] = 'Oct';
  month[10] = 'Nov';
  month[11] = 'Dec';

  return month[myMonth];
}

export function chooseStartDate(number: number) {
  let startDate = new Date();
  startDate.setDate(startDate.getDate() + number);
  return startDate;
}

export function chooseEndDate(number: number) {
  let endDate = new Date();
  endDate.setDate(endDate.getDate() + number);
  return endDate;
}
