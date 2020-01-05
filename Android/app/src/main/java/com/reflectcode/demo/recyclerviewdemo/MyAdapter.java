package com.reflectcode.demo.recyclerviewdemo;

import android.content.Context;
import android.support.design.widget.Snackbar;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.view.View.OnClickListener;
import android.widget.Toast;
import java.util.ArrayList;

public class MyAdapter extends RecyclerView.Adapter<MyAdapter.ViewHolder> {
    private ArrayList<ImageData> galleryArrayList;
    private Context context;

    public MyAdapter(Context context, ArrayList<ImageData> newArrayList) {
        this.galleryArrayList = newArrayList;
        this.context = context;
    }

    @Override
    public MyAdapter.ViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.cell_layout, viewGroup, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MyAdapter.ViewHolder viewHolder, int i) {
        viewHolder.title.setText(galleryArrayList.get(i).getImage_title());
        viewHolder.img.setScaleType(ImageView.ScaleType.CENTER_CROP);
        viewHolder.img.setImageResource((galleryArrayList.get(i).getImage_ID()));
        //Picasso.with(context).load(galleryArrayList.get(i).getImage_ID()).resize(240, 120).into(viewHolder.img);

        viewHolder.img.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context,"Image clicked",Toast.LENGTH_SHORT).show();

            }
        });

        viewHolder.title.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context,"Title clicked",Toast.LENGTH_SHORT).show();
            }
        });

        viewHolder.btnSelect.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                //Toast.makeText(context,"Button clicked",Toast.LENGTH_SHORT).show();
                Snackbar snb = Snackbar.make(v, "Button clicked", Snackbar.LENGTH_LONG);
                snb.setAction("Action", new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Log.i("RC", "Snackbar action clicked");
                        Toast.makeText(context, "Snackbar action clicked",Toast.LENGTH_SHORT).show();
                    }
                });
                snb.show();

            }
        });

    }

    @Override
    public int getItemCount() {
        return galleryArrayList.size();
    }


//*******************************

    public class ViewHolder extends RecyclerView.ViewHolder{
        TextView title;
        ImageView img;
        Button btnSelect;

        public ViewHolder(View view) {
            super(view);
            title = (TextView)view.findViewById(R.id.title);
            img = (ImageView) view.findViewById(R.id.img);
            btnSelect = (Button) view.findViewById(R.id.btnSelect);
        }

        public int getItemCount() {
            return 10;
        }

    }

}