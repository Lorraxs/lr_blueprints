import {observer} from 'mobx-react-lite';
import React, {useEffect, useRef, useState} from 'react';
import {useBluePrintsService} from '../services/blueprints/blueprints.service';
import {IoIosClose} from 'react-icons/io';
import {fetchNui} from '../utils/fetchNui';
import {FaPlay, FaSave, FaPause} from 'react-icons/fa';
import { MdDelete } from "react-icons/md";
import {IoAddOutline} from 'react-icons/io5';
import {useConfirmDialog,  useInputDialog,  useWindowSize} from 'lr-components';
import { LGraph, LGraphCanvas, LGraphNode, LiteGraph } from 'lr-litegraph';
import { VscDebugAltSmall } from "react-icons/vsc";
import clsx from 'clsx';
import { useHover  } from '@mantine/hooks';

LiteGraph.allow_scripts = true;
class MyAddNode extends LGraphNode {
  name = 'A+B';
  title = 'A+B';
  constructor() {
    super();
    this.addInput('A', 'number');
    this.addInput('B', 'number');
    this.addWidget("number", "A", 1);
    this.addOutput('A+B', 'number');
  }

  onExecute() {
    let A = this.getInputData(0);
    if (A === undefined) {
      A = 0;
    }
    let B = this.getInputData(1);
    if (B === undefined) {
      B = 0;
    }
    this.setOutputData(0, A + B);
  }
}
LiteGraph.registerNodeType('basic/sum', MyAddNode);

const LiteGraphElement = observer(() => {
  const {width, height} = useWindowSize();
  const [hovered, setHovered] = useState(false)
  const inputDialog = useInputDialog({
    title: 'Tạo mới',
    field: [{name: 'name', label: 'Tên', type: 'text'}, {name: "side", type: "select", options: [
      {label: "Client", value: "client"},
      {label: "Server", value: "server"},
      {label: "Shared", value: "shared"},
    ], label: "Excution Side"}],
  });
  const confirmDialog = useConfirmDialog({
    title: 'Confirmation',
    desc: 'Bạn có chắc chắn muốn xóa không?',
  })
  const BluePrintsService = useBluePrintsService();
  const selectedBlueprint = BluePrintsService.selectedBlueprint;
  const graphRef = useRef<LGraph | null>(null);
  const canvasRef = useRef<LGraphCanvas | null>(null);
  const refCallback = (node: HTMLCanvasElement) => {
    if (node && !canvasRef.current) {
      const graph = new LGraph();
      const canvas = new LGraphCanvas(node, graph);
      graphRef.current = graph;
      canvasRef.current = canvas;
    }
  };


  useEffect(() => {
    if (graphRef.current) {
      const graph = graphRef.current;
      if (selectedBlueprint) {
        graph.configure(selectedBlueprint.data);
      }
    }
    LiteGraph.EVENT
  }, [selectedBlueprint]);

  useEffect(() => {
    const keyHandler = (e: KeyboardEvent) => {
      canvasRef.current?.processKey(e);
    };
    window.addEventListener('keydown', keyHandler);
    return () => {
      window.removeEventListener('keydown', keyHandler);
    };
  }, []);


  if (!selectedBlueprint){
    return <div>
    <div className="flex gap-2 justify-end items-center mb-2 bg-zinc-900/90 rounded-xl p-2">
        <div className='flex gap-2'>
          <button
            className="bg-green-500 h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={async () => {
              const response = await inputDialog.getInputData();
              if (response) {
                BluePrintsService.addBlueprint(response.name, response.side);
              }
            }}
          >
            <IoAddOutline />
            <p>ADD</p>
          </button>
          
          <button
            className="bg-red-500 h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={() => {
              fetchNui('close');
            }}
          >
            <IoIosClose />
            <p>CLOSE</p>
          </button>
        </div>
      </div>
      <div className={` bg-zinc-900/90 flex justify-center items-center rounded-xl`} style={{
        width: width-200-16-8-16,
        height: height-40-8-16-16,
      }}>
        <p className='text-white font-bold'>PLEASE SELECT BLUEPRINT</p>
      </div>
      {inputDialog.dialogElement}
    </div>
  }

  return (
    <div className="relative text-white">
      <div className="flex gap-2 justify-between items-center mb-2 bg-zinc-900/90 rounded-xl p-2">
        <div className='flex'>
          <p>NAME: <span className='font-bold text-yellow-400'>{selectedBlueprint.name}</span></p>
          <p className='ml-2'>SIDE: <span className='font-bold text-yellow-400'>{selectedBlueprint.side}</span></p>
        </div>
        <div className='flex gap-2'>
          <button
            className="bg-green-500 h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={async () => {
              const response = await inputDialog.getInputData();
              if (response) {
                BluePrintsService.addBlueprint(response.name, response.side);
              }
            }}
          >
            <IoAddOutline />
            <p>ADD</p>
          </button>
          <button
            className="bg-black h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2 text-white"
            onClick={async () => {
              confirmDialog.setTitle('Confirmation');
              confirmDialog.setDesc('Are you sure you want to run the test?');
              const response = await confirmDialog.confirm();
              if (response && graphRef.current) {
                BluePrintsService.test(graphRef.current.serialize());
              }
            }}
          >
            <VscDebugAltSmall />
            <p>TEST</p>
          </button>
          <button
            className={clsx("h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2", selectedBlueprint?.start ?  'bg-yellow-500' : 'bg-green-500')}
            onClick={async () => {
              confirmDialog.setTitle('Confirmation');
              if (selectedBlueprint?.start){
                confirmDialog.setDesc('Are you sure you want to pause the blueprint?');
              }else{
                confirmDialog.setDesc('Are you sure you want to start the blueprint?');
              }
              const response = await confirmDialog.confirm();
              if (response && graphRef.current) {
                BluePrintsService.toggle();
              }
            }}
          >
            {selectedBlueprint?.start ? <FaPause /> : <FaPlay />}
            <p>{selectedBlueprint?.start ? "PAUSE" : "START"}</p>
          </button>
          <button
            className="bg-white text-black h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={async() => {
              confirmDialog.setTitle('Confirmation');
              confirmDialog.setDesc('Are you sure you want to save and run the blueprint to all players?');
              const response = await confirmDialog.confirm();
              if (response && graphRef.current) {
                BluePrintsService.save(graphRef.current.serialize());
              }
            }}
          >
            <FaSave />
            <p>SAVE</p>
          </button>
          <button
            className="bg-red-500 h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={async () => {
              if(!selectedBlueprint) return;
              confirmDialog.setTitle('Delete');
              confirmDialog.setDesc('Are you sure you want to delete?');
              const response = await confirmDialog.confirm();
              if(!response) return;
              BluePrintsService.delete()
            }}
          >
            <MdDelete />
            <p>DELETE</p>
          </button>
          <button
            className="bg-red-500 h-[40px] rounded-full p-2 px-4 hover:scale-110 flex justify-center items-center gap-2"
            onClick={() => {
              fetchNui('close');
            }}
          >
            <IoIosClose />
            <p>CLOSE</p>
          </button>
        </div>
      </div>
      <div className={` flex justify-center items-center rounded-xl overflow-hidden`} >
      <canvas width={width-200-16-8-16} height={height-40-8-16-16} ref={refCallback} style={{
          opacity: hovered ? 0.99 :0.95,
        } } onMouseEnter={()=>setHovered(true)} onMouseLeave={()=>setHovered(false)}/>
    </div>
      
      {inputDialog.dialogElement}
      {confirmDialog.confirmDialogElement}
    </div>
  );
});

export default LiteGraphElement;
