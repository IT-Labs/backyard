import React from "react";
import Countdown from "react-countdown";

function ComingSoon () {
  
    return (
      <div className="comingSoon">       

        <p> Under Construction </p>
        <Countdown
          date={new Date(2022, 3, 1, 0, 0, 0, 0)}
          intervalDelay={0}
          precision={3}
          renderer={(props) => (
            <span>
              Coming soon {props.days} days {props.hours} hours : {props.minutes} minutes : {props.seconds} seconds
            </span>
          )}
        />
      </div>
    );
  }

  export default ComingSoon;
