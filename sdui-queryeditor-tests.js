// Import Tinytest from the tinytest Meteor package.
import { Tinytest } from "meteor/tinytest";

// Import and rename a variable exported by sdui-queryeditor.js.
import { name as packageName } from "meteor/sdui-queryeditor";

// Write your tests here!
// Here is an example.
Tinytest.add('sdui-queryeditor - example', function (test) {
  test.equal(packageName, "sdui-queryeditor");
});
