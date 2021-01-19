module.exports = async function (context, commands) {
  await login(commands, context);
  await rotatePages(context, commands);

};
async function rotatePages(context, commands) {
  var pages = context.options.my.pages.split(";");
  console.log("total pages for navigating:" + pages.length);
  var count = 0;
  for (const page of pages) {
    count++;
    console.log(page + "-" + count + " from total " + pages.length);
    var items = page.split(",");
    await commands.measure.start(items[1]); // set the alias
    var url = context.options.my.host + items[0];
    await commands.navigate(url);
    await commands.measure.stop();
  }
}

async function login(commands, context) {
  commands.measure.start("login page");
  await commands.navigate(context.options.my.host);
  const loginLink = "nav_login";
  await commands.wait.byId(loginLink, 5000);
  await commands.click.byId(loginLink);

  const keycloakLogin = "kc-login";
  await commands.wait.byId(keycloakLogin, 5000);
  await commands.addText.byId(context.options.my.username, "username");
  await commands.addText.byId(context.options.my.password, "password");
   await commands.click.byId(keycloakLogin);
  await commands.measure.stop();
}

