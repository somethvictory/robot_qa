import React from 'react';
import QAPassedRobots from './robots/QAPassedRobots';
import FactorySecondRobots from './robots/FactorySecondRobots';
import ShippingList from './shipment/ShippingList';
import { remove } from 'lodash';

class Dashboard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      qaPasses: [],
      factorySeconds: [],
      shippingLists: []
    }
  }

  onAddToShipment(robot, index, category) {
    this.addToShippingList(robot, index, category)
    if(category == "factory_second") {
      this.removeFromFactorySecond(robot);
    }
    else {
      this.removeFromQAPassed(robot);
    }
  }

  onShipped(robot_ids) {
    this.setState({shippingLists: []});
  }

  addToShippingList(robot, index, category) {
    let shippingLists = this.state.shippingLists;
    robot.index       = index;
    robot.category    = category;

    shippingLists.push(robot);
    this.setState({shippingLists});
  }

  removeFromFactorySecond(robot) {
    let factorySeconds = this.state.factorySeconds;
    remove(this.state.factorySeconds, (e) => {
      return e.id == robot.id;
    });
    this.setState({factorySeconds});
  }

  removeFromQAPassed(robot) {
    let qaPasses = this.state.qaPasses;
    remove(this.state.qaPasses, (e) => {
      return e.id == robot.id;
    });
    this.setState({qaPasses})
  }

  onRemoveFromShippingList(robot) {
    this.removeFromShippingList(robot)

    if(robot.category == "factory_second") {
      this.addToFactorySecond(robot);
    }
    else {
      this.addToQAPassed(robot);
    }
  }

  removeFromShippingList(robot) {
    let shippingLists = this.state.shippingLists;
    remove(shippingLists, (e) => {
      return e.id == robot.id;
    });

    this.setState({shippingLists});
  }

  addToFactorySecond(robot) {
    let factorySeconds = this.state.factorySeconds;
    factorySeconds.splice(robot.index, 0, robot);
    this.setState({factorySeconds})
  }

  addToQAPassed(robot) {
    let qaPasses = this.state.qaPasses;
    qaPasses.splice(robot.index, 0, robot);
    this.setState({qaPasses})
  }

  render() {
    return(
      <div className="row">
        <div className="col-xs-6">
          <QAPassedRobots
            robots={ this.state.qaPasses }
            onAddToShipment={ this.onAddToShipment.bind(this) }
          />
          <FactorySecondRobots
            robots={ this.state.factorySeconds }
            onAddToShipment={ this.onAddToShipment.bind(this) }
          />
        </div>
        <div className="col-xs-6" >
          <ShippingList
            robots={ this.state.shippingLists }
            onRemoveFromShippingList={ this.onRemoveFromShippingList.bind(this) }
            onShipped={ this.onShipped.bind(this) }
          />
        </div>
      </div>
    );
  }

  componentDidMount() {
    this._getQAPassedRobots();
    this._getFactorySecondRobots();
  }

  _getQAPassedRobots() {
    self = this;
    fetch('/robots/qa_passed.json?')
      .then(response => response.json())
      .then(json => {
        self.setState({qaPasses: json});
      });
  }

  _getFactorySecondRobots() {
    self = this;
    fetch('/robots/factory_second.json?')
      .then(response => response.json())
      .then(json => {
        self.setState({factorySeconds: json});
      });
  }
}


export default Dashboard;
